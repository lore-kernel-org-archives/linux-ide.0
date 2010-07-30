From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: sata_sil24 failed command: READ FPDMA QUEUED
Date: Fri, 30 Jul 2010 12:30:24 -0600
Message-ID: <4C531A40.6080804@gmail.com>
References: <Pine.LNX.4.61.1007132245000.24693@envy.nxs.se> <4C3D134B.2090604@gmail.com> <Pine.LNX.4.61.1007140955080.24693@envy.nxs.se> <Pine.LNX.4.61.1007152103081.24693@envy.nxs.se> <Pine.LNX.4.61.1007171422530.24693@envy.nxs.se> <Pine.LNX.4.61.1007211404480.24693@envy.nxs.se> <Pine.LNX.4.61.1007211433360.24693@envy.nxs.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33046 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933250Ab0G3Say (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jul 2010 14:30:54 -0400
Received: by iwn7 with SMTP id 7so1547211iwn.19
        for <linux-ide@vger.kernel.org>; Fri, 30 Jul 2010 11:30:53 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.1007211433360.24693@envy.nxs.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomas Lund <tlund@nxs.se>
Cc: linux-ide@vger.kernel.org

On 07/21/2010 06:38 AM, Tomas Lund wrote:
> On Wed, 21 Jul 2010, Tomas Lund wrote:
>
>> Put the "LYCOM SATA PE-103 2-CH" back in the server with the Gigabyte
>> 965P-DS4 motherboard and installed the debian backports kernel
>> 2.6.32-bpo.5-amd64.
>>
>> Problem persists and a dmesg and console output (since dmesg buffer is
>> too small to fit everything) is available at:
>>
>> http://tlund.pp.se/sil24/console_2.6.32-bpo.5-amd64.txt
>> http://tlund.pp.se/sil24/dmesg_2.6.32-bpo.5-amd64.txt
>
> Tested Debian 2.6.26-2-amd64, files at the same place.

What does "hdparm -I" show when run on the drive attached to that 
controller? Is it possible there's some security locking enabled on it? 
If the BIOS is doing some kind of security unlock then it probably does 
it only on drives attached to the motherboard controller, not on any 
add-in cards. It certainly seems like the drive is returning command 
aborted on all reads when connected to that controller for whatever reason.
