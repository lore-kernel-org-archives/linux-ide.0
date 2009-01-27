From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compiling ahci.c as a module for the 2.6.18.8 kernel
Date: Tue, 27 Jan 2009 13:44:15 +0000
Message-ID: <20090127134415.421d449b@lxorguk.ukuu.org.uk>
References: <02c701c98079$852d0c90$d1664381@oucsiana2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57539 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751095AbZA0Nnx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jan 2009 08:43:53 -0500
In-Reply-To: <02c701c98079$852d0c90$d1664381@oucsiana2>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ian Atkin <ian.atkin@ict.ox.ac.uk>
Cc: linux-ide@vger.kernel.org

On Tue, 27 Jan 2009 12:19:36 -0000
"Ian Atkin" <ian.atkin@ict.ox.ac.uk> wrote:

> Hi,
> 
> I am trying to compile ahci.c as a loadable module for the 2.6.18.8 kernel
> which I used a PXE environment. This is so that I can see disks on the new
> generation of hardware coming out with the ICH10 SATA controllers.
> 
> I've downloaded my Linux 2.6.28 source

You'll also need to update all the config scripts and Makefile bits. Even
if you do that however 2.6.18 and 2.6.28 are somewhat different -
sufficiently different it wouldn't build or work.

There is a backport of the later ATA code for kernels of that sort of era
in RHEL and thus Centos that might be more helpful to you, but its a
backport of the entire layer rather than just odd driver bits.

Assuming you don't need any of the latest and greatest features however
the 2.6.18 ahci driver *ought* to drive the ICH10 SATA controller just
fine if you add the idents from 2.6.28 (or the class match for AHCI) to
it
