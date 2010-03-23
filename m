From: Tejun Heo <tj@kernel.org>
Subject: Re: [libata-dev#upstream-fixes RESEND] libata-sff: fix spurious IRQ
 handling
Date: Tue, 23 Mar 2010 22:57:43 +0900
Message-ID: <4BA8C8D7.6040209@kernel.org>
References: <4BA7253F.8070500@kernel.org> <4BA82BDF.2070308@garzik.org> <4BA83458.6010003@kernel.org> <4BA8C57D.7030502@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59074 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302Ab0CWN6S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Mar 2010 09:58:18 -0400
In-Reply-To: <4BA8C57D.7030502@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, b3nton@gmail.com, petr.uzel@centrum.cz, "Rafael J. Wysocki" <rjw@sisk.pl>

Hello, Jeff.

On 03/23/2010 10:43 PM, Jeff Garzik wrote:
> Still corrupted and not working...  Because it is an important fix, I
> manually applied it by recreating the patch, chunk by chunk.

It was TB's text flowed setting which behaves differnetly in the new
version.  The RE-RESEND I sent later is okay.  Sorry about the
trouble.

-- 
tejun
