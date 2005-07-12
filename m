From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Host protected area on suspend/resume
Date: Tue, 12 Jul 2005 16:07:39 +0100
Message-ID: <20050712150739.GA9731@srcf.ucam.org>
References: <20050712113044.GA8744@srcf.ucam.org> <42D3D87F.5040901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.81.22]:50156 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261530AbVGLPIF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Jul 2005 11:08:05 -0400
Content-Disposition: inline
In-Reply-To: <42D3D87F.5040901@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

On Tue, Jul 12, 2005 at 11:49:35PM +0900, Tejun Heo wrote:

>  This has come up several times now.  One thing I'm curious about is 
> why we are disabling HPA on boot without consent from the user.  AFAIK, 
> HPA is mostly used to implement hidden recovery/suspend storage areas 
> and disabling automatically on boot increases the likeliness of 
> destroying them.  What do we gain by disabling HPA on boot?  Are there 
> some dumb machines which unnecessarily sets HPA and reduces the capacity 
> of drives excessively?  Even in such cases, wouldn't it be better to do 
> idedisk_check_hpa() only when kernel parameter explicitly says so?

I'm not sure why we're doing it, but reverting this behaviour is likely 
to make some systems unbootable (install with kernel which disables HPA, 
format entire drive, put filesystem on it).
-- 
Matthew Garrett | mjg59@srcf.ucam.org
