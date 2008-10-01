From: Tejun Heo <tj@kernel.org>
Subject: Re: Frequent head unloads  info
Date: Wed, 01 Oct 2008 11:21:19 +0900
Message-ID: <48E2DE9F.6010501@kernel.org>
References: <op.uhjrgs2b70fqr1@blacktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58543 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbYJACW6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Sep 2008 22:22:58 -0400
In-Reply-To: <op.uhjrgs2b70fqr1@blacktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Vaselaar <andrew.vaselaar@trinity.edu>
Cc: linux-ide@vger.kernel.org

Andy Vaselaar wrote:
> 
> hdparm -B255 /dev/sda
> 
> seems to stop it from unloading the heads.

added.

-- 
tejun
