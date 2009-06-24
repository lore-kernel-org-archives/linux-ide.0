From: Patrick Voegeli Olivera <patrick.voegeli@gmail.com>
Subject: Re: Sata link_power_management_policy questions
Date: Wed, 24 Jun 2009 10:39:49 +0200
Message-ID: <4A41E655.1090401@gmail.com>
References: <4A3FD261.7060903@gmail.com> <4A40643B.7090805@gmail.com> <4A40C3D9.7060602@gmail.com> <4A4178A4.5000505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:63406 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbZFXIju (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2009 04:39:50 -0400
In-Reply-To: <4A4178A4.5000505@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org

Oh, that just sucks, but I suppose I can live without it.

Thank you

En/na Robert Hancock ha escrit:
> On 06/23/2009 06:00 AM, Patrick Voegeli Olivera wrote:
>> Here they go,
>>
>> I attach them as log files, since dmesg is quite long.
>>
>
> ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x7 impl 
> SATA mode
> ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio slum part
>
> Looks like your chipset's AHCI controller doesn't support the ALPM 
> link power management capability (it would show "pm" in this string if 
> it did).
>

