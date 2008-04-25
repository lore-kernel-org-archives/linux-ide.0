From: Christian Zankel <chris@zankel.net>
Subject: Re: [2.6 patch] xtensa: don't offer ATA
Date: Fri, 25 Apr 2008 00:58:45 -0700
Message-ID: <48118F35.3030102@zankel.net>
References: <20080414195521.GB26885@cs181133002.pp.htv.fi> <4807A771.2020405@pobox.com> <20080421193927.GA2633@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760691AbYDYH67@vger.kernel.org>
In-Reply-To: <20080421193927.GA2633@cs181133002.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Adrian,

Adrian Bunk wrote:
>> XTENSA offers HAS_IOMEM but not iomem functions?  That seems like the  
>> problem to me.
> 
> Chris, can you comment on this?

Yes, the iomem functions are missing. I finally have a board that allows 
me to test io functionality. I don't just want to add the functions 
without having the chance to test them.

-Chris
