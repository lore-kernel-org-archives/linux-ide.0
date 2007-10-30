From: Frans Pop <elendil@planet.nl>
Subject: Re: "Fix ATAPI transfer lengths" causes CD writing regression
Date: Tue, 30 Oct 2007 19:26:40 +0100
Message-ID: <E1ImvnU-0002Uq-Kh@faramir.fjphome.nl>
References: <47274A5F.6070409@gentoo.org> <20071030153417.59b9182c@the-village.bc.nu> <47276DCA.1000808@gentoo.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755832AbXJ3S0x@vger.kernel.org>
In-reply-To: <47276DCA.1000808@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Daniel Drake wrote:
> I have narrowed down the exact command submission which causes those
> nasty messages in dmesg. The function which submits this is named
> "brasero_medium_get_page_2A_write_speed_desc".

Just as an extra data point...

I've compiled the test program an ran it on my ICH7/Pentium D box running
2.6.24-rc1-192-gef49c32 (x86_64), but it does not give the error and
nothing in dmesg. I just get:
result 0

My SATA DVD-RW drive is:
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: Optiarc  Model: DVD RW AD-7170S  Rev: 1.00
  Type:   CD-ROM                           ANSI  SCSI revision: 05
