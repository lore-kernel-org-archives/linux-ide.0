From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Tue, 30 Jan 2007 08:50:13 -0700
Message-ID: <311601c90701300750w2f2f3c86k5cda7109ab0df347@mail.gmail.com>
References: <45BF5003.3000503@imc-berlin.de> <45BF512D.4040500@imc-berlin.de>
	 <311601c90701300744n294ecae7ia2dffeae55cfab1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:2310 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965038AbXA3PuP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 10:50:15 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1566598uga
        for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 07:50:14 -0800 (PST)
In-Reply-To: <311601c90701300744n294ecae7ia2dffeae55cfab1c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org

On 1/30/07, Eric D. Mudama <edmudama@gmail.com> wrote:
> 0x37 is READ NATIVE MAX ADDRESS EXT, which is the 48-bit version of
> the command to figure out how big the drive "really" is.  It appears
> that model of drive indicated support for 48-bit commands, but then
> aborted the 48-bit version of READ NATIVE MAX ADDRESS.

Er, oops, 0x27 is the read.  0x37 is the "SET MAX ADDRESS EXT" ...
would appear your drive has a host-protected area or is in the
set_max_locked/set_max_frozen state.

There's nothing functionally to worry about, but maybe your BIOS has
decided to protect part of the drive?
