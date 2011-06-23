From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] libata/sas: only set FROZEN flag if new EH is supported
Date: Fri, 24 Jun 2011 07:43:33 +1000
Message-ID: <1308865413.32158.214.camel@pasglop>
References: <20110615191747.GA6324@us.ibm.com>
	 <4DF90FCA.1040706@linux.vnet.ibm.com> <20110615233417.GB6324@us.ibm.com>
	 <20110616075114.GH8141@htj.dyndns.org>
	 <4DFA0507.3090609@linux.vnet.ibm.com> <20110616152836.GA15268@us.ibm.com>
	 <20110621160714.GA14174@us.ibm.com> <4E00FF58.7070802@linux.vnet.ibm.com>
	 <1308803461.32158.191.camel@pasglop> <1308804120.32158.202.camel@pasglop>
	 <20110623171502.GA11855@us.ibm.com>  <4E039C95.3070907@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:36251 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933154Ab1FWVn4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Jun 2011 17:43:56 -0400
In-Reply-To: <4E039C95.3070907@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian King <brking@linux.vnet.ibm.com>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Tejun Heo <tj@kernel.org>, linuxppc-dev@lists.ozlabs.org, wayneb@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, mbizon@freebox.fr, jgarzik@pobox.com

On Thu, 2011-06-23 at 15:05 -0500, Brian King wrote:
> 
> Same here.
> 
> When did this last work on this system? It seems like this is
> completely
> separate from the libata issue. 

It's separate. See my other internal message. This is a BML system and
it's broken as far as 2.6.36 but the BML "patched" kernel works,
anyways, moving that off list for now.

Cheers,
Ben.


