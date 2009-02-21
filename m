From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH] hdparm: Show form factor and media rotation rate
Date: Sun, 22 Feb 2009 01:41:20 +0300
Message-ID: <49A08310.8020100@msgid.tls.msk.ru>
References: <yq1fxi8eh7e.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isrv.corpit.ru ([81.13.33.159]:41675 "EHLO isrv.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754212AbZBUWl1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 21 Feb 2009 17:41:27 -0500
In-Reply-To: <yq1fxi8eh7e.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Martin K. Petersen wrote:
> Make hdparm display form factor and media rotation rate when using -I.

Ok, just a small (but I think very useful) nitpick:

[]
> +	/* Form factor */
> +	if(val[FORM_FACTOR] > 0) {
> +		printf("\tForm Factor: ");
> +		switch(val[FORM_FACTOR]) {
...
> +			printf("1.8 inch");
> +			break;
> +		default:
> +			printf("unknown");
> +			break;

How about printing the actual (unrecognized) value here?   Like this:

  +		default:
  +			printf("unknown (raw value = %d)", val[FORM_FACTOR]);
  +			break;

(with whatever %d needed)

Thanks!

/mjt
