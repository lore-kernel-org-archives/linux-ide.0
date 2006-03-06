From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: PATA failure with piix, works with libata
Date: Mon, 6 Mar 2006 13:15:41 +0000
Message-ID: <20060306131540.GA11265@srcf.ucam.org>
References: <20060303183937.GA30840@srcf.ucam.org> <20060305225733.GA8578@srcf.ucam.org> <440B770A.8090707@garzik.org> <20060306003221.GA8805@srcf.ucam.org> <440B8921.9030602@garzik.org> <20060306010333.GA8951@srcf.ucam.org> <440B8B39.8090007@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932214AbWCFNP4@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <440B8B39.8090007@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, Mar 05, 2006 at 08:07:05PM -0500, Jeff Garzik wrote:

> Honestly I'm quite surprised that there is a difference between legacy 
> and native mode (more joy :)).  ICH seems to want an ack to the bmdma 
> status register even on non-DMA commands, since it directly reflects the 
> IDE INTRQ line.  Perhaps pounding on the Status register will clear that 
> condition, thus enabling legacy software to continue successfully 
> without worry about this ICH-specific detail.  </speculation>

Yeah, that seems to work. Thanks! I'll see if I can clean this up...
-- 
Matthew Garrett | mjg59@srcf.ucam.org
