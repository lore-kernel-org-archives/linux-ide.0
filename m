From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: IDE generic tweak
Date: Wed, 13 Oct 2004 15:54:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1097679269.4696.18.camel@localhost.localdomain>
References: <1097677476.4764.9.camel@localhost.localdomain>
	 <20041013153152.GA5458@havoc.gtf.org>
	 <1097678363.4696.16.camel@localhost.localdomain>
	 <20041013154916.GA6832@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269373AbUJMP5O@vger.kernel.org>
In-Reply-To: <20041013154916.GA6832@havoc.gtf.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@linux.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mer, 2004-10-13 at 16:49, Jeff Garzik wrote:
> nVidia for example specifically wanted it because future __SATA__
> hardware will appear at the legacy IDE addresses, and end users were
> requesting for similar reasons.

Guess we need a pair of options with similar names to specify who
grabs the generic devices. That should be fine because it never wants
to be automatic anyway
