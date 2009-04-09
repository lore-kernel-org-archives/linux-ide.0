From: Tejun Heo <tj@kernel.org>
Subject: Re: Odd RAID failure
Date: Thu, 09 Apr 2009 11:13:06 -0700
Message-ID: <49DE3AB2.5030503@kernel.org>
References: <20090404173205.GIRT22375.cdptpa-omta01.mail.rr.com@Leslie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42696 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759369AbZDISMa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Apr 2009 14:12:30 -0400
In-Reply-To: <20090404173205.GIRT22375.cdptpa-omta01.mail.rr.com@Leslie>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: lrhorer@satx.rr.com
Cc: linux-ide@vger.kernel.org

Lelsie Rhorer wrote:
...
> The issue is the entire array will occasionally pause completely for about
> 40 seconds when a file is created.  This does not always happen, but the
> situation is easily reproducible.

Does the kernel whine about anything when this happens?

-- 
tejun
