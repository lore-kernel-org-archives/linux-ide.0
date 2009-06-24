From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Sata link_power_management_policy questions
Date: Tue, 23 Jun 2009 18:51:48 -0600
Message-ID: <4A4178A4.5000505@gmail.com>
References: <4A3FD261.7060903@gmail.com> <4A40643B.7090805@gmail.com> <4A40C3D9.7060602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:35147 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbZFXAvK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 20:51:10 -0400
In-Reply-To: <4A40C3D9.7060602@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patrick Voegeli Olivera <patrick.voegeli@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org

On 06/23/2009 06:00 AM, Patrick Voegeli Olivera wrote:
> Here they go,
>
> I attach them as log files, since dmesg is quite long.
>

ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x7 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio slum part

Looks like your chipset's AHCI controller doesn't support the ALPM link 
power management capability (it would show "pm" in this string if it did).
