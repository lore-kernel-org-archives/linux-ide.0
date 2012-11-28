From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Is FBS (FIS) working on Silicon Image 3726 port multiplier?
Date: Tue, 27 Nov 2012 19:06:02 -0600
Message-ID: <50B5637A.8050106@gmail.com>
References: <AED0AC29B70A44EA8DD19C569B87263C@diamond1720>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51730 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844Ab2K1BGG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2012 20:06:06 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so9291905iea.19
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2012 17:06:05 -0800 (PST)
In-Reply-To: <AED0AC29B70A44EA8DD19C569B87263C@diamond1720>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Norman Diamond <n0diamond@yahoo.co.jp>
Cc: linux-ide@vger.kernel.org

On 11/23/2012 07:01 PM, Norman Diamond wrote:
> I wrot on October 17, 2012 2:25 PM
>
>> I'm trying to use an SIL3726 with 5 SATA drives and an SIL3132.
>> FBS should work, right?  But performance looks like CBS.
>> Is there some way to check if FBS is actually enabled?
>
> I added some ata_dev_printk calls in file libahci.c,
> static void ahci_enable_fbs(struct ata_port *ap)
> and a few other places, but none of them were logged.
> In file libata-pmp.c, the following continues to be logged:
> if (print_info) {
> ata_dev_printk(dev, KERN_INFO, "Port Multiplier %s, "
>        "0x%04x:0x%04x r%d, %d ports, feat 0x%x/0x%x\n",
>        sata_pmp_spec_rev_str(gscr), vendor, devid,
>        sata_pmp_gscr_rev(gscr),
>        nr_ports, gscr[SATA_PMP_GSCR_FEAT_EN],
>        gscr[SATA_PMP_GSCR_FEAT]);
> ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
>
> Finally I figured out that the sil24 driver uses its own port multiplier
> code and never calls the libahci code.
>
> So the reason why it performs like CBS instead of FBS is due to
> something in the sil24 driver, or the SIL3132 HBA firmware, or the
> SIL3726 port multiplier firmware.  I still can't figure out which.

sata_sil24 doesn't support FBS. The datasheet seems to have some mention 
of FBS support in the chip, but I don't know if that's actually the case.

>
> I read that someone else got FBS working on a Marvell HBA with SIL3726
> port multiplier, but my Marvell HBA errors out in trying to detect the
> SIL3726, maybe because SAS-to-eSATA cables seem to have numerous
> problems.  My Marvell HBA also errors out trying to detect a JMicron
> port multiplier, maybe because of the same cable or maybe because
> JMicron firmware is generally pretty miserable.
>
> Does anyone have FBS (FIS) working with an SIL3726?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

