From: "Arve Knudsen" <aknuds-1@broadpark.no>
Subject: Re: System freeze when transferring large files (libata)
Date: Mon, 12 Jul 2004 17:17:36 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <opsa053mjofmr65f@mail.broadpark.no>
References: <opsavn7spjfmr65f@mail.broadpark.no> <opsaxaq20rfmr65f@mail.broadpark.no> <40EFEAE4.3060201@pobox.com> <opsa01rofkfmr65f@mail.broadpark.no> <Pine.LNX.4.60.0407121658180.32028@hosting.rdsbv.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.broadpark.no ([217.13.4.2]:34233 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S266869AbUGLPP7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jul 2004 11:15:59 -0400
In-Reply-To: <Pine.LNX.4.60.0407121658180.32028@hosting.rdsbv.ro>
List-Id: linux-ide@vger.kernel.org
To: Catalin BOIE <util@deuroconsult.ro>
Cc: linux-ide@vger.kernel.org

On Mon, 12 Jul 2004 16:59:21 +0300 (EEST), Catalin BOIE  
<util@deuroconsult.ro> wrote:

> On Mon, 12 Jul 2004, Arve Knudsen wrote:
>
>> I switched ports/cables, and lockup (DMA timeout) still occurs with the  
>> Maxtor only. I take it we can rule out the possibility of a quirk  
>> related  to the combination Promise/Maxtor? Looks like I'll be  
>> replacing this drive  with a Seagate soon.
>
> I don't know if seagate is the way to go.
> Check the blacklist in the kernel. There are a lot of drives listed.
> Maybe the new ones don't have that problem.

 From what I recall there was a problem with Seagate and Silicon Image, no?  
My current Seagate drive seems to coexist just fine with the Promise (TX2  
Plus) controller.

Regards

Arve Knudsen
