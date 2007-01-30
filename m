From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Tue, 30 Jan 2007 16:54:43 +0100
Message-ID: <45BF6A43.5070909@imc-berlin.de>
References: <45BF5003.3000503@imc-berlin.de> <45BF512D.4040500@imc-berlin.de>	 <311601c90701300744n294ecae7ia2dffeae55cfab1c@mail.gmail.com> <311601c90701300750w2f2f3c86k5cda7109ab0df347@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:3066 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965284AbXA3Pyp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 10:54:45 -0500
In-Reply-To: <311601c90701300750w2f2f3c86k5cda7109ab0df347@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: linux-ide@vger.kernel.org

Eric D. Mudama wrote:
> On 1/30/07, Eric D. Mudama <edmudama@gmail.com> wrote:
>> 0x37 is READ NATIVE MAX ADDRESS EXT, which is the 48-bit version of
>> the command to figure out how big the drive "really" is.  It appears
>> that model of drive indicated support for 48-bit commands, but then
>> aborted the 48-bit version of READ NATIVE MAX ADDRESS.
> 
> Er, oops, 0x27 is the read.  0x37 is the "SET MAX ADDRESS EXT" ...
> would appear your drive has a host-protected area or is in the
> set_max_locked/set_max_frozen state.

Well as the kernel log mentioned there is a HPA:

hda: Host Protected Area detected.
        current capacity is 78140160 sectors (40007 MB)
        native  capacity is 185074430006016 sectors (94758108163 MB)

> There's nothing functionally to worry about, but maybe your BIOS has
> decided to protect part of the drive?

What is the "SET MAX ADDRESS EXT" used for?

Steven
