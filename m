From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Read Prefetch, Post Write on IDE chipsets
Date: Sun, 02 Sep 2007 18:23:17 +0400
Message-ID: <46DAC755.5070900@ru.mvista.com>
References: <46DAB1DF.5050109@genesi-usa.com> <46DAC4E8.2070007@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:53212 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756445AbXIBOU3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Sep 2007 10:20:29 -0400
In-Reply-To: <46DAC4E8.2070007@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Matt Sealey <matt@genesi-usa.com>, linux-ide@vger.kernel.org

Hello, I wrote:

>> Does anyone have any decent information on the purpose, performance 
>> potential
>> or perhaps quirks of the "read prefetch" and "post write" buffer 
>> features on
>> some IDE chipsets?

>    Oh, I've forgotten to reply about posting. :-)
> There's a (little) wrtie post buffer in the IDE contoroller where it 
> puts the data from the PCI and GNTs the PCI transfer.  The data later 

    Perhaps I've used GNT incorrectly: it seems to be a signal between a 
master PCI device and PCI arbiter.
    So, the write buffer just helps to teminate PCI write(s) earlier than the 
data arrive to the drive.

MBR, Sergei
