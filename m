From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 04/24] libsas: remove unused ata_task_resp fields
Date: Sat, 17 Dec 2011 16:51:09 +0400
Message-ID: <4EEC903D.2030408@mvista.com>
References: <20111217022912.15036.85808.stgit@localhost6.localdomain6> <20111217023328.15036.65227.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50627 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab1LQMwL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Dec 2011 07:52:11 -0500
In-Reply-To: <20111217023328.15036.65227.stgit@localhost6.localdomain6>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org

Hello.

On 17-12-2011 6:33, Dan Williams wrote:

> Commit 1e34c838 removed the routines to fake the presence of the sata

    Please also specify that commit's summary (in parens).

> control registers, now remove the unused data structure fields to kill
> any remaining confusion.

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

MBR, Sergei
