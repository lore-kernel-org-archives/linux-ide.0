From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/2] ide: remove deprecated use of pci api
Date: Thu, 9 Apr 2015 15:35:02 +0300
Message-ID: <20150409123502.GM10964@mwanda>
References: <1428579988-10167-1-git-send-email-lambert.quentin@gmail.com>
 <1428579988-10167-2-git-send-email-lambert.quentin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:24728 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755043AbbDIMfM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Apr 2015 08:35:12 -0400
Content-Disposition: inline
In-Reply-To: <1428579988-10167-2-git-send-email-lambert.quentin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Quentin Lambert <lambert.quentin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Why are these GFP_ATOMIC allocations?

regards,
dan carpenter

