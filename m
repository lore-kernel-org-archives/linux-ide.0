From: Andras Mantia <amantia@kde.org>
Subject: Re: PATA drivers queued for 2.6.19
Date: Tue, 05 Sep 2006 00:31:00 +0300
Message-ID: <edi5uq$o4i$1@sea.gmane.org>
References: <44FC0779.9030405@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964979AbWIDVb2@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:

> 
> I just pulled the "pata-drivers" branch of libata-dev.git into the
> "upstream" branch, which means that Alan's libata PATA driver collection
> is now queued for 2.6.19.
> 
> Testing-wise, these PATA drivers have been Andrew Morton's -mm tree for
> many months.  Community-wise, no one posted objections to the PATA
> driver merge plan, when Alan posted it on LKML and linux-ide.

Does this include the patch to support the PATA port on the promise
controllers (described here
https://bugzilla.novell.com/show_bug.cgi?id=176249 ) ?

Andras
-- 
Quanta Plus developer - http://quanta.kdewebdev.org
K Desktop Environment - http://www.kde.org
