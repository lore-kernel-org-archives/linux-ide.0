From: =?UTF-8?B?576F56eJ6Yie?= <luobingjiun@gmail.com>
Subject: Why is only one command issue per time in AHCI driver?
Date: Thu, 13 Jan 2011 18:52:50 +0800
Message-ID: <AANLkTin5=NiZn6ZWZ=r-XS0v_Utrf6dpTb_YzCay-PJM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:32973 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932424Ab1AMKwv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Jan 2011 05:52:51 -0500
Received: by wyb28 with SMTP id 28so1566778wyb.19
        for <linux-ide@vger.kernel.org>; Thu, 13 Jan 2011 02:52:50 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

Inside ahci_qc_issue() function, I see that driver always write one bit
to Px.CI register even enable the NCQ.

AHCI allows to fire 32 commands at one time and AHCI driver also
claims itself able to queue up to 31 commands.

Inside ahci.c :
static struct scsi_host_template ahci_sht = {
       ATA_NCQ_SHT(DRV_NAME),
       .can_queue              = AHCI_MAX_CMDS - 1,
............

Why upper layer(Block or SCSI layer) does not fill up as many as possible
commands into Command List before sending the commands out
(Write to Px.CI register)?

How do I configure my driver so that Block layer can queue more commands
into queue list?


Regards,
BingJiun
