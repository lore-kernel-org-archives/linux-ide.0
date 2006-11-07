From: "Don Dupuis" <dondster@gmail.com>
Subject: Re: Libata and Drive Write Cache Disable
Date: Tue, 7 Nov 2006 11:56:37 -0600
Message-ID: <632b79000611070956gc2ff7e8y67457dec1d5e17cc@mail.gmail.com>
References: <632b79000611060948v267bd33ahf1ff585cf4de9fcc@mail.gmail.com>
	 <4550BE54.7060508@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:13692 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932769AbWKGR4j (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Nov 2006 12:56:39 -0500
Received: by nf-out-0910.google.com with SMTP id o25so351638nfa
        for <linux-ide@vger.kernel.org>; Tue, 07 Nov 2006 09:56:37 -0800 (PST)
In-Reply-To: <4550BE54.7060508@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

Thanks,  It worked just fine like you said. I thought I could only use
sdparm since these were SATA disks.

Don

On 11/7/06, Mark Lord <liml@rtr.ca> wrote:
> Don Dupuis wrote:
> > When will this be supported in libata. I have drives attached to a
> > AHCI controller and want to turn drive write cache OFF. Sdparm will
> > not allow me to do so. Any work-arounds or patches would be greatly
> > appreciated. I am also using kernel 2.6.18.
>
> hdparm -W0 /dev/sda
>
> It works just fine.
>
> Cheers
>
