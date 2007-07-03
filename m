From: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH] hpt366: blacklist MAXTOR STM3320620A for UltraDMA/66
Date: Tue, 3 Jul 2007 11:27:58 -0500
Message-ID: <20070703162758.GB4302@austin.ibm.com>
References: <200706292357.17374.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:34081 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580AbXGCQ2A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 12:28:00 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l63GRxQ5010149
	for <linux-ide@vger.kernel.org>; Tue, 3 Jul 2007 12:27:59 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l63GRxWn092402
	for <linux-ide@vger.kernel.org>; Tue, 3 Jul 2007 10:27:59 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l63GRw5i010772
	for <linux-ide@vger.kernel.org>; Tue, 3 Jul 2007 10:27:58 -0600
Content-Disposition: inline
In-Reply-To: <200706292357.17374.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

On Fri, Jun 29, 2007 at 11:57:17PM +0400, Sergei Shtylyov wrote:
> Add the MAXTOR STM3320620A drive into the UltraDMA/66 mode blacklist
> for the HPT36x chips.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Acked-by: Linas Vepstas <linas@austin.ibm.com>

Applied & tested & it worked for me.

--linas
