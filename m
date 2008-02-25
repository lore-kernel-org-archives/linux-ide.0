From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: 2.6.26-git0: IDE oops during boot
Date: Sun, 24 Feb 2008 23:05:21 -0800
Message-ID: <86802c440802242305o7cfce4d1h6444aab01304cb21@mail.gmail.com>
References: <20080206105334.GA3664@elf.ucw.cz>
	 <200802112035.39462.bzolnier@gmail.com>
	 <47B16113.1060807@linux.vnet.ibm.com>
	 <200802140000.10639.bzolnier@gmail.com>
	 <47B40DF2.10009@linux.vnet.ibm.com>
	 <86802c440802140228q5f6a606cyee01c711fd349571@mail.gmail.com>
	 <47B57436.5020806@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:14300 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbYBYHFZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Feb 2008 02:05:25 -0500
Received: by rv-out-0910.google.com with SMTP id k20so927288rvb.1
        for <linux-ide@vger.kernel.org>; Sun, 24 Feb 2008 23:05:21 -0800 (PST)
In-Reply-To: <47B57436.5020806@linux.vnet.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Nish Aravamudan <nish.aravamudan@gmail.com>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, ananth@in.ibm.com, Andi Kleen <andi@firstfloor.org>

On Fri, Feb 15, 2008 at 3:15 AM, Kamalesh Babulal
<kamalesh@linux.vnet.ibm.com> wrote:
>
>
>  Thanks for pointing the patch, I do not have the SES config option enabled,
>  then too i tried your patch, but that does not solve the panic. The kernel
>  panic's with the same panic message as before. I have attached the .config
>  file which i am using, please let me know if i am missing out/getting wrong
>  any option in the configuration.

can you try x86.git#testing?

http://people.redhat.com/mingo/x86.git/README

YH
