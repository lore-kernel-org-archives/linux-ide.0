From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: provide the ability to disable a disk via the
 params.
Date: Thu, 12 Dec 2013 08:39:35 -0500
Message-ID: <20131212133935.GA32683@htj.dyndns.org>
References: <1386464187-6993-1-git-send-email-robbat2@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:64283 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab3LLNjj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Dec 2013 08:39:39 -0500
Content-Disposition: inline
In-Reply-To: <1386464187-6993-1-git-send-email-robbat2@gentoo.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Robin.

On Sat, Dec 07, 2013 at 04:56:27PM -0800, Robin H. Johnson wrote:
> +		{ "disable",	.horkage_on	= ATA_HORKAGE_DISABLE },
> +		{ "nodisable",	.horkage_off	= ATA_HORKAGE_DISABLE },

Given the current usage of ATA_HORKAGE_DISABLE, I don't think we need
"nodisable".  Let's just add "disable" for now.  Can you please update
the patch and resend?

Thanks.

-- 
tejun
