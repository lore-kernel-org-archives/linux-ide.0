From: Andy Warner <andyw@pobox.com>
Subject: Re: T10/04-262 ATA pass thru - patch.
Date: Tue, 5 Oct 2004 17:37:03 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041005173703.D13871@florence.linkmargin.com>
References: <20040928001633.A8363@florence.linkmargin.com> <415AFF27.7080906@tteng.com.br> <415AFFBB.8090503@pobox.com> <4162EDA3.1030202@tteng.com.br> <20041005140653.A13393@florence.linkmargin.com> <41631DEC.9090404@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:36263 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S266249AbUJEWiy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Oct 2004 18:38:54 -0400
Content-Disposition: inline
In-Reply-To: <41631DEC.9090404@pobox.com>; from jgarzik@pobox.com on Tue, Oct 05, 2004 at 06:19:24PM -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andy Warner <andyw@pobox.com>, "Luciano A. Stertz" <luciano@tteng.com.br>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> [...]
> Probably you were running as root, and Luciano was not (guessing)

Yup - but I was only doing it to get around the device
permissions (or so I thought.) Do people think I should
add ATA_16/ATA_12 to the approved list of scsi commands ?
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
