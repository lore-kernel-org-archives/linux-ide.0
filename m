From: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: struct to be passed to ioctl call for commanf HDIO_DRIVE_CMD
Date: Wed, 4 Dec 2002 11:25:36 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20021204092536.GB1099@mea-ext.zmailer.org>
References: <54670264D99F034EA23CBB7D7A45AE7E5ECD@zenmail1.ind.zensar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54670264D99F034EA23CBB7D7A45AE7E5ECD@zenmail1.ind.zensar.com>
List-Id: linux-ide@vger.kernel.org
To: Paresh Sawant <p.Sawant@zensar.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-c-programming@vger.kernel.org

On Wed, Dec 04, 2002 at 02:38:18PM +0530, Paresh Sawant wrote:
> Hi!
>         I want to send ATA command to IDE hard disk driver using ioctl 
>	  with comand "HDIO_DRIVE_CMD", to do raw write to hard disk. 
>	  Which Struct i should pass to ioctl call as a third argument ?

  Read the source of  ide_cmd_ioctl()   at  drivers/ide/ide-taskfile.c
  Presently that is the only documentation on it.

> thanks 
> paresh
