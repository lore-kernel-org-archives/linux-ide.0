From: linux@horizon.com
Subject: Re: sata_sil24 AMD64 crash/lockup
Date: 5 Oct 2005 00:02:31 -0400
Message-ID: <20051005040231.19136.qmail@science.horizon.com>
References: <20051004221450.18205.qmail@science.horizon.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:63804 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751219AbVJEECc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Oct 2005 00:02:32 -0400
In-Reply-To: <20051004221450.18205.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux@horizon.com

> I know there are more recent kernels and sata_sil24 code, but that's
> the most current pair I could figure out how to fit together.
> 
> Trying the instructions at http://kernel.org/git/ gives me:
...
> cg-clone: pull failed

Ah, solved.  I was using a truly ancient version of cogito.  I'm still
haveing a little bit of trouble (why does .git/branches contain only the
one file "origin"?), but reality is bearing a closer resemblance to the
various FAQs and HOWTOs now.
