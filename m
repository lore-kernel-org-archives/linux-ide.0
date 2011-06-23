From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH] libata/sas: only set FROZEN flag if new EH is supported
Date: Thu, 23 Jun 2011 15:10:17 +1000
Message-ID: <1308805817.32158.204.camel@pasglop>
References: <20110615191747.GA6324@us.ibm.com>
	 <4DF90FCA.1040706@linux.vnet.ibm.com> <20110615233417.GB6324@us.ibm.com>
	 <20110616075114.GH8141@htj.dyndns.org>
	 <4DFA0507.3090609@linux.vnet.ibm.com> <20110616152836.GA15268@us.ibm.com>
	 <20110621160714.GA14174@us.ibm.com>  <4E00FF58.7070802@linux.vnet.ibm.com>
	 <1308803461.32158.191.camel@pasglop>  <1308804120.32158.202.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308804120.32158.202.camel@pasglop>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian King <brking@linux.vnet.ibm.com>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Tejun Heo <tj@kernel.org>, linuxppc-dev@lists.ozlabs.org, wayneb@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, mbizon@freebox.fr, jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

On Thu, 2011-06-23 at 14:42 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2011-06-23 at 14:31 +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2011-06-21 at 15:30 -0500, Brian King wrote:
> > > Looks good to me. Jeff/Tejun - any issues with merging this?
> > 
> > BTW. Current upstream with that patch applied on a machine here leads to
> > several oddities, I don't know at this point whether any of that is
> > actually a regression :
> 
> Ooops... pressed "send" too quickly. Here's a log excerpt with some
> comments:

 .../...

Ok so most of that is already in 2.6.39, including the odd LUN, so
nothing new under the sun.

I'll do more digging / bisection...

Ben.
