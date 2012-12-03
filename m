From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: check SATA_SETTINGS log with HW Feature Ctrl
Date: Mon, 03 Dec 2012 04:58:50 -0500
Message-ID: <50BC77DA.1060401@pobox.com>
References: <1353185081-11349-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:34171 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab2LCJ6y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2012 04:58:54 -0500
Received: by mail-qa0-f46.google.com with SMTP id r4so1226812qaq.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2012 01:58:53 -0800 (PST)
In-Reply-To: <1353185081-11349-1-git-send-email-shane.huang@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane Huang <shane.huang@amd.com>
Cc: linux-ide@vger.kernel.org

On 11/17/2012 03:44 PM, Shane Huang wrote:
> NCQ capability was used to check availability of SATA Settings page
> from Identify Device Data Log, which contains DevSlp timing variables.
> It does not work on some HDDs and leads to error messages.
> IDENTIFY word 78 bit 5(Hardware Feature Control) should be used.
>
> Quoting SATA spec 3.1:
> If Hardware Feature Control is supported, then:
> a) IDENTIFY DEVICE data word 78 bit 5 (see 13.2.1.18) shall be
> set to one;
> b) the SET FEATURES Select Hardware Feature Control subcommand
> shall be supported (see 13.3.8);
> c) page 08h of the Identify Device Data log (see 13.7.7) shall
> be supported;
>
> This patch is not tested on SATA HDD with DevSlp supported.
>
> Reported-by: Borislav Petkov <bp@amd64.org>
> Signed-off-by: Shane Huang <shane.huang@amd.com>
> ---
>   drivers/ata/libata-core.c |    3 +--
>   include/linux/ata.h       |    1 +
>   2 files changed, 2 insertions(+), 2 deletions(-)

applied



