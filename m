From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly
 return zeroes after TRIM
Date: Thu, 4 Dec 2014 21:49:46 +0000
Message-ID: <20141204214946.3ce15a90@lxorguk.ukuu.org.uk>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net>
	<547FCECB.4090908@ubuntu.com>
	<yq1sigwgkqt.fsf@sermon.lab.mkp.net>
	<547FD4F6.7090700@ubuntu.com>
	<yq1k328gk80.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:58666 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932905AbaLDVuF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2014 16:50:05 -0500
In-Reply-To: <yq1k328gk80.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Phillip Susi <psusi@ubuntu.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Wed, 03 Dec 2014 22:35:59 -0500
"Martin K. Petersen" <martin.petersen@oracle.com> wrote:

> >>>>> "Phillip" == Phillip Susi <psusi@ubuntu.com> writes:
> 
> Phillip> On 12/03/2014 10:24 PM, Martin K. Petersen wrote:
> >> Well. It's a bit stronger than wishful thinking given that OEM
> >> product requirements documents and supply contracts make it so. But
> >> it is not something we can get in writing.
> 
> Phillip> OEM product requirements documents and supply contracts sound
> Phillip> like forms of writing to me.
> 
> Except they are not forms of writing that we as a community have access
> to.

Thats true of many things we reply upon.

I assume it's something vaguely of the form

Vendor A has agreed with Oracle that drive identity X will do this and
meet some certification so Oracle can approve it for databases

Oracle has agreed to break vendor A's legs if it doesn't

Oracle would rather like that the kernel just knows about this drive as
being good, based on the above.

In which case IMHO it's good enough. "Do not p*ss off a major customer"
is probably more watertight than a lot of signed paper things 8)

Alan
