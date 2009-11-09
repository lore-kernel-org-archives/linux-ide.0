From: Tejun Heo <tj@kernel.org>
Subject: Re: Errors when powering on eSATA box
Date: Mon, 09 Nov 2009 18:09:05 +0900
Message-ID: <4AF7DC31.2080507@kernel.org>
References: <4AE9FDE6.5040203@aon.at> <4AEA2C54.9040502@gmail.com> <4AEB635F.50404@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37643 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754671AbZKIJJG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Nov 2009 04:09:06 -0500
In-Reply-To: <4AEB635F.50404@aon.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Klotz <peter.klotz@aon.at>
Cc: linux-ide@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>

Hello,

Peter Klotz wrote:
> Yes, it is a Silicon Image (Sil5744) box.
> 
> Thanks for this explanation.
> 
> Now I am stuck with this box.
> 
> BIG mode shows these errors and I will not trust a system showing that
> many errors on startup.

It will be okay.  It just looks much worse due to ACPI errors but that
won't affect normal operation.  Other than that, it's just the config
device going away and the pseudo container device coming online.

-- 
tejun
