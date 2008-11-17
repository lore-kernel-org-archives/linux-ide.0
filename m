From: Tejun Heo <tj@kernel.org>
Subject: Re: Frequent head unloading
Date: Mon, 17 Nov 2008 12:46:17 +0900
Message-ID: <4920E909.2030400@kernel.org>
References: <4920292B.5060804@gc-web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44005 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755649AbYKQDqZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 22:46:25 -0500
In-Reply-To: <4920292B.5060804@gc-web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Clausen <alex@gc-web.de>
Cc: linux-ide@vger.kernel.org

Alexander Clausen wrote:
> Hi,
> I _think_ I got a case of frequent head unloading here. See attachments.
> 
>    hdparm -B255 /dev/sda
> 
> seems to stop the clunking noises.

How often does the clunking noises happen?

-- 
tejun
