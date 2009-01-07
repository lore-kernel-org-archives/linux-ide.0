From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [Bugme-new] [Bug 12351] New: sata_nv hotplug not work in	2.6.27.10
Date: Tue, 06 Jan 2009 18:19:44 -0600
Message-ID: <4963F520.4060500@shaw.ca>
References: <bug-12351-10286@http.bugzilla.kernel.org/> <20090105153644.8a0eea74.akpm@linux-foundation.org> <4962AC5C.1000605@shaw.ca> <20090106102758.GA7309@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:18145 "EHLO
	idcmail-mo1so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbZAGATq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Jan 2009 19:19:46 -0500
In-Reply-To: <20090106102758.GA7309@libero.it>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gpanco@tiscali.it
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, stable@kernel.org, Tejun Heo <tj@kernel.org>

Giovanni Pancotti wrote:
> On Monday 05 January 2009, alle 18:57, Robert Hancock wrote:
> 
>>>> Hardware Environment:x86 ASUS M2N-E
>> OK, this is an MCP61 board. We're now using softreset instead of hardreset 
>> on hotplug and apparently that doesn't work. Thing is that:
> 
> no, it is not MCP61, but MCP55:

Ahh, ok, that is less contradictory then :-) Presumably we should still 
be using hardreset on that chipset.

> 
> dual ~ # lspci
> 00:00.0 RAM memory: nVidia Corporation MCP55 Memory Controller (rev a1)
> 00:01.0 ISA bridge: nVidia Corporation MCP55 LPC Bridge (rev a2)
> 00:01.1 SMBus: nVidia Corporation MCP55 SMBus (rev a2)
> 00:02.0 USB Controller: nVidia Corporation MCP55 USB Controller (rev a1)
> 00:02.1 USB Controller: nVidia Corporation MCP55 USB Controller (rev a2)
> 00:04.0 IDE interface: nVidia Corporation MCP55 IDE (rev a1)
> 00:05.0 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)
> 
> dual ~ # dmidecode
> # dmidecode 2.9
> SMBIOS 2.4 present.
> 72 structures occupying 2069 bytes.
> Table at 0x000F0000.
> 
> Handle 0x0000, DMI type 0, 24 bytes
> BIOS Information
>         Vendor: Phoenix Technologies, LTD
>                 Version: ASUS M2N-E ACPI BIOS Revision 1601
> 
> 
