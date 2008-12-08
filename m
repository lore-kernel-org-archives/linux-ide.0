From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] libata: Add two more columns to the ata_timing table.
Date: Tue, 09 Dec 2008 02:19:03 +0300
Message-ID: <493DAB67.3090605@ru.mvista.com>
References: <4939B402.9010004@caviumnetworks.com> <1228518561-16242-1-git-send-email-ddaney@caviumnetworks.com> <493ADE48.6050709@ru.mvista.com> <493D65C8.2060808@caviumnetworks.com> <493D6C0F.7070809@ru.mvista.com> <493D6DA1.3090801@ru.mvista.com> <493D873C.3020202@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:44009 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753064AbYLHXTK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Dec 2008 18:19:10 -0500
In-Reply-To: <493D873C.3020202@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org

Hello.

David Daney wrote:

>>    OK, t6z is yet longer than t9 but putting it into the table seems 
>> pointless anyway as it's fixed at 30 ns, at least for the standard 5 
>> PIO modes (and for other two modes 30 ns would be good anyway).
>>    Though frankly speaking I don't quite understand your care for 
>> this timing, if the ATA standard permits -CE deasserted and data bus 
>> being driven to overlap.
>
> It doesn't matter what the ATA standard permits in this case.  We need 
> to assure that the OCTEON Boot Bus standard is respected.  There are 
> several timing parameters that we have to set based on the documented 
> properties of the device.  Ideally if we try to run bus cycles for 
> non-ATA/CF devices that share the signal lines of the Boot Bus, they 
> should  not interfere with the CF interface.

   Well, your driver is free to handle it on its own, and even respect a 
lesser minimum for PIO5/6. It just doesn't seem practical to add this to 
the table. In fact, about all PATA hardware on market only permits to 
control the active/recovery and the address setup times -- that's why 
the table looks like it looks now.

> David Daney

MBR, Sergei


