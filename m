From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problems (and confusions) with Intel ICH7 SATA controller
Date: Thu, 08 Feb 2007 08:38:14 -0500
Message-ID: <45CB27C6.9090309@gmail.com>
References: <1170536373.7892.5.camel@localhost>  <45C956CA.80709@gmail.com> <1170928530.31971.1.camel@lapnavab35.informatik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:2271 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423029AbXBHNi1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Feb 2007 08:38:27 -0500
Received: by an-out-0708.google.com with SMTP id b33so479659ana
        for <linux-ide@vger.kernel.org>; Thu, 08 Feb 2007 05:38:26 -0800 (PST)
In-Reply-To: <1170928530.31971.1.camel@lapnavab35.informatik.tu-muenchen.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-ide@vger.kernel.org

Florian Echtler wrote:
> That would be 2.6.18. I've also tried 2.6.19, but it had the same
> problems and the ipw3945 wireless driver didn't work there, so I kept
> 2.6.18 for the time being.

I see.  Please post '/var/log/boot.msg', the result of 'dmesg' and 
'lspci -nn'.  Let's see which drivers you're using.

-- 
tejun
