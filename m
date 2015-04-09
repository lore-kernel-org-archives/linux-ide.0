From: Quentin Lambert <lambert.quentin@gmail.com>
Subject: Re: [PATCH 2/2] ide: replace GFP_ATOMIC by GFP_KERNEL
Date: Thu, 09 Apr 2015 16:33:47 +0200
Message-ID: <55268DCB.3010201@gmail.com>
References: <1428579988-10167-1-git-send-email-lambert.quentin@gmail.com> <1428579988-10167-3-git-send-email-lambert.quentin@gmail.com> <20150409123633.GN10964@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38872 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbbDIOew (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Apr 2015 10:34:52 -0400
In-Reply-To: <20150409123633.GN10964@mwanda>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org



On 09/04/2015 14:36, Dan Carpenter wrote:
> Oh.  They're not GFP_ATOMIC.
>
> Fold these two patches together into one patch and resend.
The reason I did it that way is because I feel that the two patches 
really are different.
The first one do not change the execution of the code but the second one 
does.
Could you explain to me why they can be folded into one ?

regards,
Quentin
