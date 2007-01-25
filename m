From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ahci: improve and limit spurious interrupt messages, take#3
Date: Thu, 25 Jan 2007 17:24:30 -0500
Message-ID: <45B92E1E.3060600@pobox.com>
References: <20070115090117.GL10987@htj.dyndns.org> <20070116065239.GO10987@htj.dyndns.org> <45B806DA.1050107@pobox.com> <45B8626B.9090002@gmail.com> <20070125101628.GA8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40569 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030638AbXAYWYb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Jan 2007 17:24:31 -0500
In-Reply-To: <20070125101628.GA8606@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> We're still seeing a lot of issues with NCQ implementation in drive
> firmwares.  Sprious FISes during NCQ command phase occur on many
> drives and some of them seem potentially dangerous (at least to me).
> Until we find the solution, spurious messages can give us more info.
> Improve and limit them such that more info can be reported while not
> disturbing users too much.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Fixed as advised.  Thanks.

applied to #upstream-fixes


