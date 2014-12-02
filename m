From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [nForce4] - Repeatable issues with nForce 4
Date: Mon, 1 Dec 2014 19:38:05 -0600
Message-ID: <CADLC3L3bdYRtkE1LRKc3VL3G-AcYddaL5381Qho6hCUVW7bnDg@mail.gmail.com>
References: <CAO18KQjN88PjQSh0bMo+YgqmSSE--eaxL3Lgo5QeUjg3vMu6iQ@mail.gmail.com>
	<20140914093721.GA9028@mtj.dyndns.org>
	<CADLC3L397fmyWa1CpzZfkTkZavyKPG4M7JccdgbgTRTsUp8VVQ@mail.gmail.com>
	<CAO18KQjP785u-jiucmRFczNTRLPJMnbXm7ukvRBNvdSaW6KUhg@mail.gmail.com>
	<CADLC3L1BvbouQEqbdu2iDuk73-UO6a_O84gCpfaYfD6pPuLvoA@mail.gmail.com>
	<CAO18KQgEn8qWozNmySU_S7vT1XSN+FfXM-1uqRWaVdOMc6sPbw@mail.gmail.com>
	<CADLC3L3wRkmz-1qvVptiERQAPUhtRmSid5oQ-dfNveLrPFkg2A@mail.gmail.com>
	<CAO18KQhQghMPv0PR01FCgYAmgdLRGAvZ-WFLxLeoz4H9ct-b0Q@mail.gmail.com>
	<CADLC3L2nTrowBeBU=TRVELUjRahOnJxqkUTqxXSbjj9sQ+U2NQ@mail.gmail.com>
	<CAO18KQgFF+qxhXnFtxpbZiEn2KqKB3OQ=ZFLWxEXf0ia+jotMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:34693 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932280AbaLBBiH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Dec 2014 20:38:07 -0500
Received: by mail-qc0-f171.google.com with SMTP id r5so8589237qcx.2
        for <linux-ide@vger.kernel.org>; Mon, 01 Dec 2014 17:38:05 -0800 (PST)
In-Reply-To: <CAO18KQgFF+qxhXnFtxpbZiEn2KqKB3OQ=ZFLWxEXf0ia+jotMw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jacobo Pantoja <jacobopantoja@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Mon, Dec 1, 2014 at 4:37 PM, Jacobo Pantoja <jacobopantoja@gmail.com> wrote:
>> Looks like it's doing a hardreset now (apparently successfully).
>> However the reason it still does a softreset anyway is this at the end
>> of nv_hardreset:
>>
>>         /* device signature acquisition is unreliable */
>>         return -EAGAIN;
>>
>> Try changing that to:
>>
>>         return 0;
>>
>> and see if that changes the behavior. That should make it skip the
>> soft-reset. Whether or not the device works or not after that, or if
>> it still locks up at some later point, we'll see.
>
> Ok, after changing -EAGAIN to 0, I cannot boot it completely (it
> cannot find the rootfs). Every 10s aprox. it stops, but after some 10
> tries, it gives up with a panic.
>
> I have made pictures but not processed yet (I will soon, but I doubt
> they are going to be useful).
>
> I guess that the only useful stuff I can do is booting from a USB.
> With my MoBo it is difficult, I will have to play with GRUB.
>
> I will be back.

OK, well obviously doing a hardreset unconditionally doesn't work
well. How about changing the code in that function to this -
basically, only skip hardreset for initial probing, otherwise use
hardreset and skip follow-up softreset:

    if (!(link->ap->pflags & ATA_PFLAG_LOADING))
        return sata_link_hardreset(link, sata_deb_timing_hotplug, deadline,
                    NULL, NULL);
    else {
        const unsigned long *timing = sata_ehc_deb_timing(ehc);
        int rc;

        if (!(ehc->i.flags & ATA_EHI_QUIET))
            ata_link_info(link,
                      "nv: skipping hardreset on occupied port\n");

        /* make sure the link is online */
        rc = sata_link_resume(link, timing, deadline);
        /* whine about phy resume failure but proceed */
        if (rc && rc != -EOPNOTSUPP)
            ata_link_warn(link, "failed to resume link (errno=%d)\n",
                      rc);
    }

    /* device signature acquisition is unreliable */
    return -EAGAIN;
