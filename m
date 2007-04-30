From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [git patches] libata updates
Date: Mon, 30 Apr 2007 15:52:33 -0400
Message-ID: <46364901.4000907@redhat.com>
References: <20070429161542.GA12501@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:40967 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031110AbXD3Twg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Apr 2007 15:52:36 -0400
In-Reply-To: <20070429161542.GA12501@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Jeff Garzik wrote:
> 
> Jeff Garzik (8):
>       libata/IDE: remove combined mode quirk

You can't just remove the "combined_mode=" kernel parameter or
every Linux user who uses that will get an unbootable kernel
with no good way of diagnosing the problem. It should still
be accepted and just print a warning.

