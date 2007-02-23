From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: fix remaining ap->id
Date: Fri, 23 Feb 2007 05:37:41 -0500
Message-ID: <45DEC3F5.5040805@garzik.org>
References: <20070221073633.GW1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44910 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932119AbXBWKhn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Feb 2007 05:37:43 -0500
In-Reply-To: <20070221073633.GW1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Merge order left libata-acpi and pata_scc with remainling usage of
> ap->id.  Kill superflous id printing and substitute the remaining ones
> with ap->print_id.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


