From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: linux-2.4.28 released
Date: Fri, 19 Nov 2004 09:42:12 -0500
Message-ID: <419E0644.909@pobox.com>
References: <BF571719A4041A478005EF3F08EA6DF05EB481@pcsmail03.pcs.pc.ome.toshiba.co.jp> <20041118111235.GA26216@logos.cnet> <20041119134832.GA9552@havoc.gtf.org> <20041119135452.GA10422@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21947 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261433AbUKSOm2
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Nov 2004 09:42:28 -0500
In-Reply-To: <20041119135452.GA10422@devserv.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>, Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Fri, Nov 19, 2004 at 08:48:32AM -0500, Jeff Garzik wrote:
> 
>>PATA and SATA (DMA doesn't work for PATA, in split-driver configuration),
>>and there is no split-driver to worry about.
>>
>>I think there may need to be some code to prevent the IDE driver from
>>claiming the legacy ISA ports.
> 
> 
> Its called "request_resource". If you want the resource claim it. IDE will
> be a good citizen.

That's what the quirk does.  libata still needs to find out who obtained 
the resource, not blindly grab it (and fail).

	Jeff



