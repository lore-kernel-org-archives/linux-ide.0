From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCHv2] ata: endianness annotations in pata drivers
Date: Fri, 27 Jun 2008 02:56:29 -0400
Message-ID: <48648F1D.9040509@garzik.org>
References: <1213829582.2125.24.camel@brick>	 <20080618233332.GN28946@ZenIV.linux.org.uk> <1213834603.2125.34.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54728 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760269AbYF0G4d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jun 2008 02:56:33 -0400
In-Reply-To: <1213834603.2125.34.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, linux-ide <linux-ide@vger.kernel.org>

Harvey Harrison wrote:
> drivers/ata/pata_qdi.c:142:9: warning: incorrect type in assignment (different base types)
> drivers/ata/pata_qdi.c:142:9:    expected unsigned int [unsigned] [usertype] pad
> drivers/ata/pata_qdi.c:142:9:    got restricted __le32 [usertype] <noident>
> drivers/ata/pata_qdi.c:146:15: warning: cast to restricted __le32
> 
> drivers/ata/pata_winbond.c:110:9: warning: incorrect type in assignment (different base types)
> drivers/ata/pata_winbond.c:110:9:    expected unsigned int [unsigned] [usertype] pad
> drivers/ata/pata_winbond.c:110:9:    got restricted __le32 [usertype] <noident>
> drivers/ata/pata_winbond.c:114:15: warning: cast to restricted __le32
> 
> drivers/ata/pata_legacy.c:310:9: warning: incorrect type in assignment (different base types)
> drivers/ata/pata_legacy.c:310:9:    expected unsigned int [unsigned] [usertype] pad
> drivers/ata/pata_legacy.c:310:9:    got restricted __le32 [usertype] <noident>
> drivers/ata/pata_legacy.c:314:15: warning: cast to restricted __le32
> drivers/ata/pata_legacy.c:752:11: warning: cast to restricted __le32
> drivers/ata/pata_legacy.c:756:9: warning: incorrect type in assignment (different base types)
> drivers/ata/pata_legacy.c:756:9:    expected unsigned int [unsigned] [addressable] [assigned] [usertype] pad
> drivers/ata/pata_legacy.c:756:9:    got restricted __le32 [usertype] <noident>
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> ---
> Al, have incorporated your comments.
> 
>  drivers/ata/pata_legacy.c  |   10 ++++------
>  drivers/ata/pata_qdi.c     |    2 +-
>  drivers/ata/pata_winbond.c |    2 +-
>  3 files changed, 6 insertions(+), 8 deletions(-)

applied


