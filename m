From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: 28 Mar 2008 09:48:45 +0100
Message-ID: <873aqbkzde.fsf@basil.nowhere.org>
References: <12066128663306-git-send-email-htejun@gmail.com>
	<47EBAE2B.8070102@rtr.ca> <87bq4zl29s.fsf@basil.nowhere.org>
	<47ECACBB.2060207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out02.alice-dsl.net ([88.44.60.12]:24822 "EHLO
	smtp-out02.alice-dsl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbYC1Iss (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Mar 2008 04:48:48 -0400
In-Reply-To: <47ECACBB.2060207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Tejun Heo <htejun@gmail.com> writes:

> Regarding the boot time exception, which
> version was it and do you have logs?

I tried first 2.6.25-rc4 and then 2.6.24 (similar behaviour).

My impression was also that the exception handling was very 
heavy handed -- is it really needed to always reset the link
on each error? 

I'll send you full logs (huge) in separate mail.

-Andi
