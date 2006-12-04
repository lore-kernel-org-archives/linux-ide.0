From: "Thinus Viljoen" <thinus.viljoen@gmail.com>
Subject: Disabling SATA hardware interrupts
Date: Mon, 4 Dec 2006 13:08:50 +0200
Message-ID: <c70dbe410612040308o5cbe878cue4ce98c088776afc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.226]:9134 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S935734AbWLDLIz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Dec 2006 06:08:55 -0500
Received: by wx-out-0506.google.com with SMTP id h27so3762307wxd
        for <linux-ide@vger.kernel.org>; Mon, 04 Dec 2006 03:08:50 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi

I have the following questions:
1. Is it possible to (temporarily) disable the SATA hardware from
generating interrupts (either the controller or the actual HDD)?
2. if so, how?
3. if so, is it safe?

My setup is as follows:
Modules loaded:
ata_piix, libata, scsi_mod, ahci (ahci doesn't seem to be used)

SATA controller (from lspci):
00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA
Controller (rev 04)

HDD:
Hitachi Travelstar, model HTS541080G9SA00

Reason: I am building a real-time system using RTAI. I do not need to
access the HDD while in real-time mode, but I must access another
peripheral which shares the interrupt with libata. I want do disable
the libata interrupts while in real-time mode, to improve the timing
characteristics of the real-time peripheral.

Thanks
Thinus Viljoen
