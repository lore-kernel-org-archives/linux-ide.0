From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: Process Scheduling Issue using sg/libata
Date: Sat, 17 Nov 2007 00:20:36 -0700
Message-ID: <8202f4270711162320s2eb1d48dwb1430f4a779809a9@mail.gmail.com>
References: <8202f4270711161649v75d06d35kd1d56e36d272a883@mail.gmail.com>
	 <473E6E62.9090309@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <473E6E62.9090309@rtr.ca>
Content-Disposition: inline
Sender: linux-scsi-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-scsi@vger.kernel.org, Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org

On 11/16/07, Mark Lord <liml@rtr.ca> wrote:
> Fajun Chen wrote:
> > Hi All,
> >
> > I use sg/libata and ata pass through for read/writes. Linux 2.6.18-rc2
> > and libata version 2.00 are loaded on ARM XScale board.  Under heavy
> > cpu load (e.g. when blocks per transfer/sector count is set to 1),
> > I've observed that the test application can suck cpu away for long
> > time (more than 20 seconds) and other processes including high
> > priority shell can not get the time slice to run.  What's interesting
> > is that if the application is under heavy IO load (e.g. when blocks
> > per transfer/sector count is set to 256),  the problem goes away. I
> > also tested with open source code sg_utils and got the same result, so
> > this is not a problem specific to my user-space application.
> ..
>
> Post the relevant code here, and then we'll be able to better understand
> and explain it to you.
>
> For example, if the code is using ATA opcodes 0x20, 0x21, 0x24,
> 0x30, 0x31, 0x34, 0x29, 0x39, 0xc4 or 0xc5 (any of the R/W PIO ops),
> then this behaviour does not surprise me in the least.  Fully expected
> and difficult to avoid.
>

This problem also happens with R/W DMA ops. Below are simplified code snippets:
    // Open one sg device for read
      if ((sg_fd  = open(dev_name, O_RDWR))<0)
      {
          ...
      }
      read_buffer = (U8 *)mmap(NULL, buf_sz, PROT_READ | PROT_WRITE,
                             MAP_SHARED, sg_fd, 0);

    // Open the same sg device for write
      if ((sg_fd_wr = open(dev_name, O_RDWR))<0)
      {
         ...
      }
      write_buffer = (U8 *)mmap(NULL, buf_sz, PROT_READ | PROT_WRITE,
                             MAP_SHARED, sg_fd_wr, 0);

      sg_io_hdr_t io_hdr;

      memset(&io_hdr, 0, sizeof(sg_io_hdr_t));

      io_hdr.interface_id = 'S';
      io_hdr.mx_sb_len    = sizeof(sense_buffer);
      io_hdr.sbp          = sense_buffer;
      io_hdr.dxfer_len    = dxfer_len;
      io_hdr.cmd_len      = cmd_len;
      io_hdr.cmdp         = cmdp;    // ATA pass through command block
      io_hdr.timeout      = cmd_tmo * 1000;       // In millisecs
      io_hdr.pack_id = id;  // Read/write counter for now
      io_hdr.iovec_count=0;   // scatter gather elements, 0=not being used

      if (direction == 1)
      {
        io_hdr.dxfer_direction = SG_DXFER_TO_DEV;
        io_hdr.flags |= SG_FLAG_MMAP_IO;
        status = ioctl(sg_fd_wr, SG_IO, &io_hdr);
      }
      else
      {
        io_hdr.dxfer_direction = SG_DXFER_FROM_DEV;
        io_hdr.flags |= SG_FLAG_MMAP_IO;
        status = ioctl(sg_fd, SG_IO, &io_hdr);
      }
      ...
Mmaped IO is a moot point here since this problem is also observed
when using direct IO.

Thanks,
Fajun
