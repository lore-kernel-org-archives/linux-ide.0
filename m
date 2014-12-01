From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [nForce4] - Repeatable issues with nForce 4
Date: Sun, 30 Nov 2014 23:52:40 -0600
Message-ID: <CADLC3L2nTrowBeBU=TRVELUjRahOnJxqkUTqxXSbjj9sQ+U2NQ@mail.gmail.com>
References: <CAO18KQjN88PjQSh0bMo+YgqmSSE--eaxL3Lgo5QeUjg3vMu6iQ@mail.gmail.com>
	<20140914093721.GA9028@mtj.dyndns.org>
	<CADLC3L397fmyWa1CpzZfkTkZavyKPG4M7JccdgbgTRTsUp8VVQ@mail.gmail.com>
	<CAO18KQjP785u-jiucmRFczNTRLPJMnbXm7ukvRBNvdSaW6KUhg@mail.gmail.com>
	<CADLC3L1BvbouQEqbdu2iDuk73-UO6a_O84gCpfaYfD6pPuLvoA@mail.gmail.com>
	<CAO18KQgEn8qWozNmySU_S7vT1XSN+FfXM-1uqRWaVdOMc6sPbw@mail.gmail.com>
	<CADLC3L3wRkmz-1qvVptiERQAPUhtRmSid5oQ-dfNveLrPFkg2A@mail.gmail.com>
	<CAO18KQhQghMPv0PR01FCgYAmgdLRGAvZ-WFLxLeoz4H9ct-b0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:59904 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbaLAFwk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Dec 2014 00:52:40 -0500
Received: by mail-qa0-f45.google.com with SMTP id x12so6772448qac.18
        for <linux-ide@vger.kernel.org>; Sun, 30 Nov 2014 21:52:40 -0800 (PST)
In-Reply-To: <CAO18KQhQghMPv0PR01FCgYAmgdLRGAvZ-WFLxLeoz4H9ct-b0Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jacobo Pantoja <jacobopantoja@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sun, Nov 30, 2014 at 10:40 PM, Jacobo Pantoja
<jacobopantoja@gmail.com> wrote:
> On 1 December 2014 at 01:01, Robert Hancock <hancockrwd@gmail.com> wrote:
>> On Sun, Nov 30, 2014 at 5:03 AM, Jacobo Pantoja <jacobopantoja@gmail.com> wrote:
>>> Hello,
>>>
>>> It took me a while, but I got time to recompile and reproduce the
>>> lockup with ultra-verbose output.
>>>
>>> Three out of four lockups seem identical (1, 2 and 4) but number 3
>>> seems different. The trigger mechanism was the same: connect through
>>> ssh (verbose screen made impossible working locally), start dd'ing
>>> from disk to /dev/null in an area with some bad sectors, and wait
>>> until lockup.
>>>
>>> It is 100% reproducible, at least for the moment.
>>>
>>> The link with the 4 photos:
>>> https://drive.google.com/folderview?id=0B4EqBXYvV-kTR2daRm1GYVBDbWs&usp=sharing
>>>
>>> Any idea about what to test now?
>>
>> It would appear that (in at least 3 of the 4 pictures) the lockup is
>> happening during softreset. You can try changing this code in
>> sata_nv.c:
>>
>>     /* Do hardreset iff it's post-boot probing, please read the
>>      * comment above port ops for details.
>>      */
>>     if (!(link->ap->pflags & ATA_PFLAG_LOADING) &&
>>         !ata_dev_enabled(link->device))
>>         sata_link_hardreset(link, sata_deb_timing_hotplug, deadline,
>>                     NULL, NULL);
>>     else {
>>         const unsigned long *timing = sata_ehc_deb_timing(ehc);
>>         int rc;
>>
>>         if (!(ehc->i.flags & ATA_EHI_QUIET))
>>             ata_link_info(link,
>>                       "nv: skipping hardreset on occupied port\n");
>>
>>         /* make sure the link is online */
>>         rc = sata_link_resume(link, timing, deadline);
>>         /* whine about phy resume failure but proceed */
>>         if (rc && rc != -EOPNOTSUPP)
>>             ata_link_warn(link, "failed to resume link (errno=%d)\n",
>>                       rc);
>>     }
>>
>> to just hard-reset unconditionally:
>>
>>         sata_link_hardreset(link, sata_deb_timing_hotplug, deadline,
>>                     NULL, NULL);
>>
>> and see what that does to the behavior. This function has to deal with
>> quite the comedy of errors that is reset handling on NV SATA, and it
>> may be that the actual error-handling case is one where a hardreset is
>> actually needed.
>>
>
> Still same behaviour. I don't understand why does it softreset still
> (but my knowledge is limited), I have checked several times that I
> have modified the code as you proposed. Perhaps the code deciding
> whether soft or hard is placed in a different area or file?
>
> I have uploaded 4 new pictures, and again, one is different than the rest.

Looks like it's doing a hardreset now (apparently successfully).
However the reason it still does a softreset anyway is this at the end
of nv_hardreset:

        /* device signature acquisition is unreliable */
        return -EAGAIN;

Try changing that to:

        return 0;

and see if that changes the behavior. That should make it skip the
soft-reset. Whether or not the device works or not after that, or if
it still locks up at some later point, we'll see.
