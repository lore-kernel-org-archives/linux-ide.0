From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: 28 Mar 2008 08:46:07 +0100
Message-ID: <87bq4zl29s.fsf@basil.nowhere.org>
References: <12066128663306-git-send-email-htejun@gmail.com>
	<47EBAE2B.8070102@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out01.alice-dsl.net ([88.44.60.11]:23732 "EHLO
	smtp-out01.alice-dsl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbYC1HqK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Mar 2008 03:46:10 -0400
In-Reply-To: <47EBAE2B.8070102@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Mark Lord <liml@rtr.ca> writes:
> 
> Really, the entire flush + retries etc.. should never, ever, be permitted
> to take more than XX seconds total.  Not 60 seconds per retry, but XX seconds
> total for the original command + however many retries we can fit in there.

I fully agree. Also please make that user limit settable use module_param too,
not only sysfs. I recently had the pleasure to deal with a failing disk
which started to spew errors already on device probing and it somewhat
annoyed me that that slowed down boot up time that much. Perhaps the default
during device probing should be also lower?

-Andi
