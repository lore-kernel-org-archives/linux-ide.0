From: Tejun Heo <tj@kernel.org>
Subject: Re: Intermittent SATA link down SStatus 0
Date: Mon, 25 Jan 2010 14:06:55 +0900
Message-ID: <4B5D26EF.4030709@kernel.org>
References: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47724 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776Ab0AYFAk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Jan 2010 00:00:40 -0500
In-Reply-To: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Check <paul@thechecks.ca>
Cc: linux-ide@vger.kernel.org

On 01/22/2010 12:57 AM, Paul Check wrote:
> I am having an intermittent problem:
> 
> ata1.01: SATA link down (SStatus 0 SControl 301)
> 
> which is causing one of my four hard drives to not get recognized.

Most likely fixed by commit 5040ab67a2c6d5710ba497dc52a8f7035729d7b0.
Can you please try 2.6.33-rc5?

Thanks.

-- 
tejun

