From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: ahci fails with SATA DVD drive, IDE mode works
Date: Tue, 3 Mar 2009 16:23:52 -0500
Message-ID: <20090303162352.23432dd1@dhcp-100-2-144.bos.redhat.com>
References: <20090211174558.505354fe@dhcp-100-2-144.bos.redhat.com>
	<499D2202.7070503@kernel.org>
	<20090221181705.0b5f9ed3@dhcp-100-2-144.bos.redhat.com>
	<49A4DFD4.3030206@kernel.org>
	<20090225181530.1c575a30@dhcp-100-2-144.bos.redhat.com>
	<49A5EB45.6050202@kernel.org>
	<20090227175746.44acdbfa@dhcp-100-2-144.bos.redhat.com>
	<49AA7EF9.7000306@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:41304 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751852AbZCCVYE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Mar 2009 16:24:04 -0500
In-Reply-To: <49AA7EF9.7000306@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Sun, 01 Mar 2009 21:26:33 +0900
Tejun Heo <tj@kernel.org> wrote:

> > I ran 'hdparm -I' here. Why would it send BLANK to the drive??
> > (There was a 1.4 GB DVD-RW in the drive when I did that.)
> 
> CDB 0xa1 is BLANK alright.  Is the problem reproducible?
> 

Happens every time.

