From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Read Prefetch, Post Write on IDE chipsets
Date: Sun, 02 Sep 2007 18:12:56 +0400
Message-ID: <46DAC4E8.2070007@ru.mvista.com>
References: <46DAB1DF.5050109@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:53166 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932627AbXIBOKI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Sep 2007 10:10:08 -0400
In-Reply-To: <46DAB1DF.5050109@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: linux-ide@vger.kernel.org

Matt Sealey wrote:

> Does anyone have any decent information on the purpose, performance 
> potential
> or perhaps quirks of the "read prefetch" and "post write" buffer 
> features on
> some IDE chipsets?

    Oh, I've forgotten to reply about posting. :-)
There's a (little) wrtie post buffer in the IDE contoroller where it puts the 
data from the PCI and GNTs the PCI transfer.  The data later get output to the 
IDE bus when the IDE timings are met, so the slow IDE transfers (which usually 
need to wait for active/recovery time) doesn't hog the PCI too.

MBR, Sergei
