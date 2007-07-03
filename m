From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 01/12] libata: update EH report formatting
Date: Tue, 03 Jul 2007 10:22:32 -0400
Message-ID: <468A5BA8.9070705@garzik.org>
References: <1183283616149-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60414 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759428AbXGCOWg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 10:22:36 -0400
In-Reply-To: <1183283616149-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> Update formatting for LLD provided error descriptions such that...
> 
> * No default () around it
> * Each element is separated by <> not ,
> 
> This change makes each element responsible for putting a space after
> itself instead of before - e.g. "<elem> " not ", elem".  This is more
> conventional and allows more flexible combination of messages.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

either way, it is messy.

I guarantee that programmers are not going to remember always to add a 
"magic space" after certain error descriptions.  It is far, far better 
for the upper layer to help out a bit, and insert a space and/or comma 
for the LLDD.  After all, the LLDD might not be the only one printing 
error messages at that time; the upper layer might also wish to do so in 
the same dmesg line.


