From: AYAN KUMAR HALDER <ayankumarh@gmail.com>
Subject: Re: Linux Hibernation with sata driver
Date: Tue, 3 Jun 2014 10:44:50 +0530
Message-ID: <CAGAs2Amc9YSHNrxAJYOJG0RoZOy7w=f9g9q_G_2jUbg8ZBcubw@mail.gmail.com>
References: <CAGAs2AmTe5wip-B58fnM9i4We=f4SWYsQz8GiswYEvWTOMdu9w@mail.gmail.com>
	<CAGAs2AnLtMfJ12ZWzgNYoufy9ia=ocCuf4_h9dWNb=fqhBV2vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:54949 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbaFCFOv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jun 2014 01:14:51 -0400
Received: by mail-pd0-f174.google.com with SMTP id r10so4156913pdi.5
        for <linux-ide@vger.kernel.org>; Mon, 02 Jun 2014 22:14:50 -0700 (PDT)
In-Reply-To: <CAGAs2AnLtMfJ12ZWzgNYoufy9ia=ocCuf4_h9dWNb=fqhBV2vQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

subscribe linux-ide

On Tue, Jun 3, 2014 at 10:05 AM, AYAN KUMAR HALDER <ayankumarh@gmail.com> wrote:
> Hi,
>
> I am working with Linux hibernation framework on ARM based custom SOC
> which has SATA controller on PCI bus.
>
> I see that when the system resumes from hibernation, the SATA
> controller(drivers/ata/ahci.c) on PCI bus fails to come up. My
> understanding is that the hibernation calls 'freeze' of all devices.
> The SATA controller receives the power state event as PM_EVENT_FREEZE
> ( ie pdev->dev.power.power_state.event = PM_EVENT_FREEZE). Thus when
> system restores the hibernation image, ahci_pci_device_resume gets
> called in which ahci_pci_reset_controller/ahci_pci_init_controller
> does not get called. So SATA controller fails to come up.
>
> Please let me know if my understanding is correct or not. If so, then
> in ahci_pci_device_resume() should we change the following
> if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND)
> to
> if (pdev->dev.power.power_state.event == PM_EVENT_FREEZE)
>
> In hibernation , as we power down the system, so I understand that the
> sata controller need to be reset and re-initialized for proper
> functioning.
>
> Regards,
> Ayan Kumar Halder
