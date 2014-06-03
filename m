From: AYAN KUMAR HALDER <ayankumarh@gmail.com>
Subject: Fwd: Linux Hibernation with sata driver
Date: Tue, 3 Jun 2014 10:05:25 +0530
Message-ID: <CAGAs2AnLtMfJ12ZWzgNYoufy9ia=ocCuf4_h9dWNb=fqhBV2vQ@mail.gmail.com>
References: <CAGAs2AmTe5wip-B58fnM9i4We=f4SWYsQz8GiswYEvWTOMdu9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:43968 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbaFCEfZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jun 2014 00:35:25 -0400
Received: by mail-pd0-f180.google.com with SMTP id y13so4162919pdi.11
        for <linux-ide@vger.kernel.org>; Mon, 02 Jun 2014 21:35:25 -0700 (PDT)
In-Reply-To: <CAGAs2AmTe5wip-B58fnM9i4We=f4SWYsQz8GiswYEvWTOMdu9w@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi,

I am working with Linux hibernation framework on ARM based custom SOC
which has SATA controller on PCI bus.

I see that when the system resumes from hibernation, the SATA
controller(drivers/ata/ahci.c) on PCI bus fails to come up. My
understanding is that the hibernation calls 'freeze' of all devices.
The SATA controller receives the power state event as PM_EVENT_FREEZE
( ie pdev->dev.power.power_state.event = PM_EVENT_FREEZE). Thus when
system restores the hibernation image, ahci_pci_device_resume gets
called in which ahci_pci_reset_controller/ahci_pci_init_controller
does not get called. So SATA controller fails to come up.

Please let me know if my understanding is correct or not. If so, then
in ahci_pci_device_resume() should we change the following
if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND)
to
if (pdev->dev.power.power_state.event == PM_EVENT_FREEZE)

In hibernation , as we power down the system, so I understand that the
sata controller need to be reset and re-initialized for proper
functioning.

Regards,
Ayan Kumar Halder
