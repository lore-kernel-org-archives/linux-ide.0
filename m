From: Alan Cox <alan@redhat.com>
Subject: Re: linux-2.4.28 released
Date: Fri, 19 Nov 2004 08:54:52 -0500
Message-ID: <20041119135452.GA10422@devserv.devel.redhat.com>
References: <BF571719A4041A478005EF3F08EA6DF05EB481@pcsmail03.pcs.pc.ome.toshiba.co.jp> <20041118111235.GA26216@logos.cnet> <20041119134832.GA9552@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:423 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261401AbUKSNzW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Nov 2004 08:55:22 -0500
Content-Disposition: inline
In-Reply-To: <20041119134832.GA9552@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>, Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alan@redhat.com

On Fri, Nov 19, 2004 at 08:48:32AM -0500, Jeff Garzik wrote:
> PATA and SATA (DMA doesn't work for PATA, in split-driver configuration),
> and there is no split-driver to worry about.
> 
> I think there may need to be some code to prevent the IDE driver from
> claiming the legacy ISA ports.

Its called "request_resource". If you want the resource claim it. IDE will
be a good citizen.

Alan

