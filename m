From: "Patrick Ale" <patrick.ale@gmail.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Sat, 24 Feb 2007 13:24:40 +0100
Message-ID: <8d158e1f0702240424p1c6204afi6c4e6700403f156b@mail.gmail.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>
	 <8d158e1f0702201400w622bbcb2lc7711b5c8974bfcd@mail.gmail.com>
	 <45DBEB63.3010905@gmail.com>
	 <8d158e1f0702210447q4ee8526cke05a76f895ad824c@mail.gmail.com>
	 <45DC46DF.8030704@gmail.com>
	 <8d158e1f0702211030p542a8332w5b20318ca6b922e9@mail.gmail.com>
	 <45DE74CA.2010603@gmail.com>
	 <8d158e1f0702230041i7d3c28a4r202d9f8f628120f4@mail.gmail.com>
	 <45DEB600.8060109@garzik.org>
	 <8d158e1f0702230216qb72e7a8nbf5f41b91ae2c81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:27106 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbXBXMYm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Feb 2007 07:24:42 -0500
Received: by wx-out-0506.google.com with SMTP id h31so779795wxd
        for <linux-ide@vger.kernel.org>; Sat, 24 Feb 2007 04:24:41 -0800 (PST)
In-Reply-To: <8d158e1f0702230216qb72e7a8nbf5f41b91ae2c81@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, albertl@mail.com, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On 2/23/07, Patrick Ale <patrick.ale@gmail.com> wrote:
> On 2/23/07, Jeff Garzik <jeff@garzik.org> wrote:
> > Is this detection problem limited to Promise controllers?

No, seems to limited to stupid cables only.

Look, I bought a new cable and see what happens:

pata_pdc2027x 0000:00:0f.0: PLL input clock 33509 kHz
Linux video capture interface: v2.00
ata5: PATA max UDMA/133 cmd 0xf98a17c0 ctl 0xf98a1fda bmdma 0xf98a1000 irq 19
ata6: PATA max UDMA/133 cmd 0xf98a15c0 ctl 0xf98a1dda bmdma 0xf98a1008 irq 19
scsi4 : pata_pdc2027x
ata5: CLASSIFY: device 0 50:01 01:00:00
ata5: CLASSIFY: device 1 50:01 01:00:00
ata5.00: ATA-7: Maxtor 6Y160P0, YAR41BW0, max UDMA/133
ata5.00: 320173056 sectors, multi 16: LBA48
ata5.01: ATA-6: WDC WD1200JB-00DUA3, 75.13B75, max UDMA/100
ata5.01: 234441648 sectors, multi 16: LBA48
ata5.00: configured for UDMA/33
ata5.01: configured for UDMA/100
scsi5 : pata_pdc2027x
ata6: CLASSIFY: device 0 50:01 01:00:00
ata6: CLASSIFY: device 1 50:01 01:00:00
ata6.00: ATA-6: WDC WD1200JB-00EVA0, 15.05R15, max UDMA/100
ata6.00: 234441648 sectors, multi 16: LBA48
ata6.01: ATA-6: ST3120022A, 8.54, max UDMA/100
ata6.01: 234441648 sectors, multi 16: LBA48
ata6.00: configured for UDMA/100
ata6.01: configured for UDMA/100


I can't believe this sh*t, I tried 3 sets of cables, non of them
worked, now I buy a new cable and things get detected at once?

*sigh*

Thanks for your help all, I really appriciate it... it still looks
very weird to me but a fact is, with this new cable things do seem to
work.


Patrick
