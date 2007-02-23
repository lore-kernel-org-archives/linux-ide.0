From: "Patrick Ale" <patrick.ale@gmail.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Fri, 23 Feb 2007 11:16:59 +0100
Message-ID: <8d158e1f0702230216qb72e7a8nbf5f41b91ae2c81@mail.gmail.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>
	 <8d158e1f0702200405w6a0e817bx3d809540d28b843d@mail.gmail.com>
	 <8d158e1f0702201400w622bbcb2lc7711b5c8974bfcd@mail.gmail.com>
	 <45DBEB63.3010905@gmail.com>
	 <8d158e1f0702210447q4ee8526cke05a76f895ad824c@mail.gmail.com>
	 <45DC46DF.8030704@gmail.com>
	 <8d158e1f0702211030p542a8332w5b20318ca6b922e9@mail.gmail.com>
	 <45DE74CA.2010603@gmail.com>
	 <8d158e1f0702230041i7d3c28a4r202d9f8f628120f4@mail.gmail.com>
	 <45DEB600.8060109@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:49400 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133AbXBWKRB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Feb 2007 05:17:01 -0500
Received: by wr-out-0506.google.com with SMTP id i31so515805wra
        for <linux-ide@vger.kernel.org>; Fri, 23 Feb 2007 02:17:00 -0800 (PST)
In-Reply-To: <45DEB600.8060109@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, albertl@mail.com, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On 2/23/07, Jeff Garzik <jeff@garzik.org> wrote:
> Is this detection problem limited to Promise controllers?
>
> It's possible we might be programming the Promise controllers in "dual
> master" mode, and then accidentally missing the second channel somehow.

Good point and good news, I have a free bus on my VIA controller
aswell, not really free, but I can disconnect the DVD writer to test
this.

Will do so when I am home.


Patrick
